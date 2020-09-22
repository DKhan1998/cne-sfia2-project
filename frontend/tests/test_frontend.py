import unittest
from flask_testing import TestCase
from flask import url_for
import requests

from application import app
from os import getenv

class TestBase(TestCase):
    def create_app(self):
        config_name = 'testing'
        return app
    
class TestViews(TestBase):
    def test_backend_response(self):
        response = self.client.get(url_for('get_users'))
        self.assertEqual(response.status_code, 200)

    import xmlrunner
    runner = xmlrunner.XMLTestRunner(output='test-reports')
    unittest.main(testRunner=runner)
