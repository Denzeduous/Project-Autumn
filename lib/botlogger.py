from datetime import datetime
from sys import path
from os.path import isfile

path.append('../')

import config as conf


'''
    Global Constants
'''


DEBUG   = 10 # For debugging purposes
DEFAULT = 20 # The default, essentially 'INFO' on normal logger
ERROR   = 30 # For explicitly ONLY error messages

CONSOLE = 1


'''
    Logger classes
'''


class Configuration:
    def __init__(self,
                 name: str = conf.DEFAULT_LOGGER['name'],
                 level: int = conf.DEFAULT_LOGGER['level'], destination = conf.DEFAULT_LOGGER['destination'],
                 write_type: str = conf.DEFAULT_LOGGER['write_type'], rotating: bool = conf.DEFAULT_LOGGER['rotating'],
                 message_style = conf.DEFAULT_LOGGER['message_style']
                ):
        """
        Configuration class for the logger.

        :param: name Name of the config
        :param: level Logger level
        :param: destination Destination of logger output
        :param: write_type Writing type of the logger. Unused if destination is console.
        :param: rotating If destination is not console, tells logger if it should rotate files
        :param: message_style Format for the messages
        """

        self.name = name
        self.level = level
        self.destination = destination
        self.write_type = write_type
        self.rotating = rotating

        # Not possible to use ternary expression here
        if message_style is None:
            self.message_style = lambda message, type: f'{datetime.now().hour}:{datetime.now().minute} {name} | {type} | >> {message}'
        else:
            self.message_style = message_style


class Logger:
    def __init__(self, config: Configuration):
        """
        :param: config Configuration for the logger
        """

        self.config = config
        self.output_amount = 0

    def debug(self, message: str):
        """
        Sends debug message to destination

        :param: message Message to send
        """

        if self.config.level == DEBUG:
            if self.config.destination is CONSOLE:
                print(self.config.message_style(message, 'DEBUG'))

            else:
                with open(self.config.destination, self.config.write_type) as f:
                    f.write(self.config.message_style(message, 'DEBUG') + '\n')

    def send(self, message: str):
        """
        Sends message to destination
        
        :param: message Message to send
        """

        if self.config.level <= DEFAULT:
            if self.config.destination is CONSOLE:
                print(self.config.message_style(message, 'INFO'))

            else:
                with open(self.config.destination, self.config.write_type) as f:
                    f.write(self.config.message_style(message, 'INFO') + '\n')

    def error(self, message: str):
        """
        Sends error message to destination
        
        :param: message Message to send
        """

        if self.config.level <= ERROR:
            if self.config.destination is CONSOLE:
                print(self.config.message_style(message, 'ERROR'))

            else:
                with open(self.config.destination, self.config.write_type) as f:
                    f.write(self.config.message_style(message, 'ERROR') + '\n')

    def verbose(self, message: str):
        if conf.verbose:
            if self.config.destination is CONSOLE:
                print(self.config.message_style(message, 'VERBOSE'))

            else:
                with open(self.config.destination, self.config.write_type) as f:
                    f.write(self.config.message_style(message, 'VERBOSE') + '\n')


'''
    Default constant
'''


DEFAULT_CONFIG = Configuration(conf.DEFAULT_LOGGER['name'],
                               conf.DEFAULT_LOGGER['level'],
                               conf.DEFAULT_LOGGER['destination'],
                               conf.DEFAULT_LOGGER['write_type'],
                               conf.DEFAULT_LOGGER['rotating'],
                               conf.DEFAULT_LOGGER['message_style']
                 )

DEFAULT_LOGGER = {
        'name': 'root',
        'level': DEBUG, 
        'destination': CONSOLE,
        'write_type': 'a',
        'rotating': False,
        'message_style': None
}
