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

        # Connect to database
        # Access Sessions.ActiveSessions
            # Get other user's ID and save it
            # Make sure to also save the `session_id`
            # Also save whether or not it is a helper (for the following step)
        # Save `session_id`, `user_id`, `reported_id`, `macro`, `reason`, and `date` in the respective `Reports` table
            # Save the `report_id` generated. Link showing how to do so in PostreSQL: https://stackoverflow.com/a/2944481

        # Make sure to save the other's user ID as other_user_id so the f-string can inject it properly
        ticket(user_id, reported_id, macro, reason, user=user_id)
        ticket(user_id, reported_id, macro, reason)
        
        # Send user a message letting them know it has been reported and that the session will now be closed (on their end).
        # Send other user a message letting them know that the session has been closed by the Helpee/Helper (don't let them know why)

    async def ticket(report_id, user=None):
        """Sends a ticket through an embed by using a `report_id`.
        """
        
        # Get `user_id`, `reported_id`, `macro`, and `reason` from the `report_id` in the `Reports` table
        ticket(user_id, reported_id, macro, reason, user=user)
        
    async def ticket(user_id, reported_id, macro: str, reason: str, user=None):
        """Sends a ticket through an embed to a specified location.
        """
        
        # Make sure to save the other's user ID as other_user_id so the f-string can inject it properly
        report_template = f'\{{user_id}\} reported \{{reported_id}\} for \{{macro}\}.\nReason:\n{reason}'
        
        # Send report_template to `user` through an embed.
        # Use https://cog-creators.github.io/discord-embed-sandbox/ to make a template, then inject the data in.
        
        # If `user` is None, send to hard-coded User Support chat.
        
    @commands.group(name='report', help='- Command group for reporting other users. !help report for commands.')
    async def report_group(self, ctx):
        pass

    @report.command(name='troll', help='- Command for reporting a troll in your current session.')
    async def report_troll(self, ctx, reason: str):
        """- Reports a troll in your current session.
        """

        await report('Trolling', reason)

    @report.command(name='insensitivity', help='- Command for reporting an insensitive or rude user in your current session.',
                    aliases=['insensitivity', 'insensitive', 'rude', 'trigger', 'triggering']):
        """- Reports a rude and/or insensitive user in your current session.
        """
        
        await report('Insensitivity', reason)
        
    @report.command(name='other', help='- Command for reporting any other type of negative behavior or actions taken by another user in your current session.',
                    aliases=['other', 'misc', 'miscellaneous', 'NA']):
        """- Reports a user for a behavior or action taken in your current session that is not specified in the current commands.
        """
        
        await report('Other', reason)
