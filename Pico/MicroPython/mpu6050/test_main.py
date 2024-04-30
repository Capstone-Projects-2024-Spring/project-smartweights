import pytest
from unittest.mock import MagicMock, patch

# Mock the machine module before importing MPU6050
with patch.dict('sys.modules', {'machine': MagicMock()}):
    from MPU6050 import MPU6050

@pytest.fixture
def mock_i2c():
    return MagicMock()

@pytest.fixture
def mpu(mock_i2c):
    return MPU6050(mock_i2c)

def test_wake(mpu, mock_i2c):
    mpu.wake()
    mock_i2c.writeto_mem.assert_called_once_with(mpu.address, 0x6B, bytes([0x01]))

def test_sleep(mpu, mock_i2c):
    mpu.sleep()
    mock_i2c.writeto_mem.assert_called_once_with(mpu.address, 0x6B, bytes([0x40]))

def test_who_am_i(mpu, mock_i2c):
    mock_i2c.readfrom_mem.return_value = bytes([0x68])
    assert mpu.who_am_i() == 0x68
    mock_i2c.readfrom_mem.assert_called_once_with(mpu.address, 0x75, 1)