# Discord imports
import discord
from discord.ext import commands
from discord.errors import Forbidden
from discord.ext.commands.errors import MissingRequiredArgument

# Built-in imports
from datetime import datetime
from os import makedirs, listdir, path
import traceback

# Dependency imports
import asyncpg

# In-house imports
import config as conf
from lib import botlogger as log

import credentials as cd



# Globals

desc_file = 'bot_description.txt'

with open(desc_file) as f:
    description = f.read()

bot = commands.Bot(command_prefix='!', description=description, pm_help=True)

logger_file = conf.LOGFILE_STYLE()

logger = log.Logger(log.Configuration('run'))
file_logger = log.Logger(config=log.Configuration('main', level=log.ERROR, destination=logger_file, rotating=True))


@bot.event
async def on_ready():
    """Function called when the bot finishes its connection and successfully logs in.
    """

    global reaction_cache
    global db

    credentials = cd.credentials
    db = await asyncpg.create_pool(**credentials)

    bot.db = db

    date = datetime.now()

    logger.send(f'Logged in as: {bot.user.name}, {bot.user.id}')
    logger.send('-' * 64)
    logger.send(f'Date: {date.month}/{date.day}/{date.year} at {date.hour}:{date.minute}:{date.second}\n')

    extension_load()


@bot.event
async def on_message(message: discord.Message):
    """Function called on all messages. Used for ranking system and command calling.
    """

    global db
    
    if not message.author.bot:
        try:
            await bot.process_commands(message)


        except MissingRequiredArgument:
            command = message.content.split(' ')[0]
            arguments = ' '.join(message.content.split(' ')[1:])
            logger.verbose(f"User {message.author.name} attempted command {command} with incorrect arguments: {arguments}")
            await message.channel.send('**Error:** Missing required argument. Please check your syntax.')

        except discord.ext.commands.errors.CommandNotFound:
            command = message.content.split(' ')[0]
            arguments = ' '.join(message.content.split(' ')[1:])
            logger.verbose(f"User {message.author.name} attempted non-existing command {command} with the arguments: {arguments}")
            await message.channel.send(f"**Error:** Command *{command}* does not exist.")



# Cogs

def extension_load():
    """Loads all of the extensions. Was originally in the __name__ block, but moved for proper global variable importation.
    """

    extensions = listdir('cogs')

    # Parenthesis added purely for readability.
    # Checks to make sure it doesn't load any potentially generated folders/files.
    extension_check = lambda ext: ('__' not in ext) and (ext.replace('.py', '')) or None
    startup_extensions = [extension_check(extension) for extension in extensions]

    for extension in startup_extensions:

        try:
            if not extension is None and not path.isdir('cogs/' + extension):
                bot.load_extension('cogs.' + extension)
                logger.send(f'Loaded extension {extension}...')

        except ImportError as e:
            exc = f'{type(e).__name__}: {e}'
            logger.send(f'Failed to load extension {extension}\n{exc}\n')

    logger.send('Bot startup extension loading has completed. Bot is now ready for interaction.')
    logger.send('-' * 64 + '\n')


def load(extension_name: str, extension_dir: str = ''):
    """Loads a cog extension into the bot."""

    try:
        bot.load_extension(extension_dir.replace('/', '.') + extension_dir and '.' or '' + extension_name)

    except (AttributeError, ImportError) as e:
        date = datetime.now()

        if not path.isdir('/logs'):
            makedirs('/logs')

        with open(f'logs/{date.month}-{date.day}-{date.year}-{date.hour}-{date.minute}-{date.second}', 'w+') as f:
            f.write(e)

    logger.debug('{} loaded successfully.'.format(extension_dir.replace('/', '.') + extension_dir and '.' or '' + extension_name))


def unload(extension_name: str, extension_dir: str = ''):
    """Unloads a cog extension from the bot."""
    bot.unload_extension(extension_dir.replace('/', '.') + extension_dir and '.' or '' + extension_name)
    logger.debug('{} loaded successfully.'.format(extension_dir.replace('/', '.') + extension_dir and '.' or '' + extension_name))


if __name__ == '__main__':

    with open('token.txt') as f:
        bot.run(f.read())