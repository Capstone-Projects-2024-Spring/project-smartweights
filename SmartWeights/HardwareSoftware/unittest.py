'''placeholder file for potential unit tests for the pico.'''


from unittest.mock import MagicMock

def test():
    mock = MagicMock()
    mock.method()
    mock.method.assert_called_once()