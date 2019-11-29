# Discord imports
import discord
from discord.ext import commands
from discord.errors import Forbidden
from discord.ext.commands.errors import MissingRequiredArgument, CommandNotFound

# Built-in imports
from datetime import datetime
from os import makedirs, listdir, path

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
file_logger = log.Logger(config=log.Configuration('run', level=log.ERROR, destination=logger_file, rotating=True))


@bot.event
async def on_ready():
    """Function called when the bot finishes its connection and successfully logs in.
    """

    date = datetime.now()

    logger.send(f'Logged in as: {bot.user.name}, {bot.user.id}')
    logger.send('-' * 64)
    logger.send(f'Date: {date.month}/{date.day}/{date.year} at {date.hour}:{date.minute}:{date.second}\n')

    extension_load()


@bot.event
async def on_message(message: discord.Message):
    """Function called on all messages. Used for command calling and sending session chats.
    """
    
    # Checking to make sure the author isn't a bot
    if not message.author.bot:
        try:
            # Since we're overriding the default `on_message`, we need to process the command
            await bot.process_commands(message)

        # Checking to make sure require arguments aren't missing
        except MissingRequiredArgument:
            command = message.content.split(' ')[0]
            arguments = ' '.join(message.content.split(' ')[1:])
            logger.verbose(f'User {message.author.name} attempted command {command} with incorrect arguments: {arguments}')
            await message.channel.send('**Error:** Missing required argument. Please check your syntax.')

        # Checking to make sure the command exists
        except CommandNotFound:

            # Getting the `session_id` from `ActiveSessions` and making sure it exists
            session_id = get_session(message.author.id)

            if (check_session(message, session_id)):
                send_chat(message, session_id)

            else:
                command = message.content.split(' ')[0]
                arguments = ' '.join(message.content.split(' ')[1:])
                logger.verbose(f'User {message.author.name} attempted non-existing command {command} with the arguments: {arguments}')
                await message.channel.send(f'**Error:** Command *{command}* does not exist.')


async def check_session(message: discord.Message, session_id) -> bool:
    """Checks message validity for chat functionality.
    """

    # Call chat function if:
        # 1. Message was sent through DMs
        # 2. Message is not a command
        # 3. User has a session ongoing
            # Check if `session_id` is not default return value (most likely null or None)


async def send_chat(message: discord.Message, session_id, is_helper: bool):
    """Sends chat to specified user in a session.
    """

    # Final message should be put through embed_template
    # If is_helper:
        # Connect to db
        # Get `help` ID from `ActiveSessions` using `session_id`
            # Prepared statement!
        # Send to `help` DM using ID
    # Else:
        # Connect to db
        # Get `helper` ID from `ActiveSessions` using `session_id`
            # Prepared statement!
        # Send to `helper` DM using ID


def embed_template(name, content):
    """Returns an embed template for `send_chat`.
    """

    # Use https://cog-creators.github.io/discord-embed-sandbox/ to make a template, then concatenate the data in


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
        # Dynamic cog directory magic. Ignore this, it works.
        bot.load_extension(extension_dir.replace('/', '.') + (extension_dir and '.' or '') + extension_name)

    except (AttributeError, ImportError) as e:
        date = datetime.now()

        if not path.isdir('/logs'):
            makedirs('/logs')

        with open(f'logs/{date.month}-{date.day}-{date.year}-{date.hour}-{date.minute}-{date.second}', 'w+') as f:
            f.write(e)

    logger.debug('{} loaded successfully.'.format(extension_dir.replace('/', '.') + extension_dir and '.' or '' + extension_name))


def unload(extension_name: str, extension_dir: str = ''):
    """Unloads a cog extension from the bot."""

    # Dynamic cog directory magic. Ignore this, it works.
    bot.unload_extension(extension_dir.replace('/', '.') + (extension_dir and '.' or '') + extension_name)
    logger.debug('{} loaded successfully.'.format(extension_dir.replace('/', '.') + (extension_dir and '.' or '') + extension_name))


if __name__ == '__main__':
    with open('token.txt') as f:
        bot.run(f.read())