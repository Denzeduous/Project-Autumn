from datetime import datetime

"""
	Constants to be left UNTOUCHED
"""

DEBUG = 10 # For debugging purposes
DEFAULT = 20 # The default, essentially 'INFO' on normal logger
ERROR = 30 # For explicitly ONLY error messages

CONSOLE = 1

"""
	Logger config
"""

verbose = True

DEFAULT_LOGGER = {
		'name': 'root',
		'level': DEBUG, 
		'destination': CONSOLE,
		'write_type': 'a',
		'rotating': False,
		'message_style': None
}

LOGFILE_STYLE = lambda: f'./logs/{datetime.now().month}_{datetime.now().day}_{datetime.now().year}-{datetime.now().hour}_{datetime.now().minute}.log'

# Alternate file default for DEFAULT_LOGGER

#DEFAULT_LOGGER =
#{
#		name: 'root',
#		level = DEFAULT, 
#		destination = '../logs/log.log',
#		write_type = 'a',
#		rotating = True,
#		message_style = None
#}