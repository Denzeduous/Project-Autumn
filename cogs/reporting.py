# Discord imports
import discord
from discord.ext import commands

# Built-in imports
from datetime import datetime

# In-house imports
from ..lib import botlogger as log

logger = log.logger(log.Configuration('report'))

class Reporting(commands.Cog):
    def __init__(self, bot):
        self._bot = bot

    async def report(user_id, macro: str, reason: str):
        """Saves a report in the database.
        """

        report_template = f'\{{user_id}\} reported \{{other_user_id}\} using for \{{macro}\}.\nReason:\n{reason}'

    @commands.group(name='report', help='- Command group for reporting other users. !help report for commands.')
    async def report_group(self, ctx):
        pass

    @report.command(name='troll', help='- Command for reporting a troll in your current session.')
    async def report_troll(self, ctx, reason: str):
        """- Reports a troll in your current session.
        """

        # 

    @report.command(name='insensitivity', help='- Command for reporting an insensitive or rude user in your current session.',
                    aliases=['insensitivity', 'insensitive', 'rude']):
        """- Reports a rude and/or insensitive user in your current session.
        """