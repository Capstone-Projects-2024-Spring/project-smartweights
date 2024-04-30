import pytest
import random


def mock_get_accel_data() -> tuple:
    
    #Get random values for x, y, z since the actual values are reliant on the MPU6050 sensor
    x = random.uniform(-100, 100)  
    y = random.uniform(-100, 100)  
    z = random.uniform(-100, 100)
    return (x,y,z)
    
    
def mock_get_gyro_data() -> tuple:
    
    #Get random values for x, y, z since the actual values are reliant on the MPU6050 sensor
    x = random.uniform(-100, 100)  
    y = random.uniform(-100, 100)  
    z = random.uniform(-100, 100) 
    return (x,y,z)


def test_mock_get_accel_data():
    result = mock_get_accel_data()
    
    # Assert that the method has returned the expected value
    assert result is not None
    assert len(result) == 3
    assert isinstance(result[0], float)
    assert isinstance(result[1], float)
    assert isinstance(result[2], float)
    
    
    
def test_mock_get_gyro_data():
    # Call the method you want to test
    result = mock_get_gyro_data()
    
    # Assert that the method has returned the expected value
    assert result is not None
    assert len(result) == 3
    assert isinstance(result[0], float)
    assert isinstance(result[1], float)
    assert isinstance(result[2], float)