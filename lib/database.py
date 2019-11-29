# Dependency imports
import asyncpg

# In-house imports
from .. import credentials as cd

def get_session(user_id):
    """Gets the `session_id` from a `user_id`.
    """

    # Connect to database
        # Syntax:
            # credentials = cd.Sessions
            # db = await asyncpg.create_pool(**credentials)
        # Get `session_id` from `ActiveSessions`. Check both `help_id` and `helper_id`
            # Use a prepared statement. Even though it's safe because it's purely through Discord, better to be safe than sorry