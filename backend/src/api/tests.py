from django.test import TestCase
from django.urls import reverse
from .views import ping
# Create your tests here.


class Test_Ping_View(TestCase):

    def test_ping(self):
        url = reverse("api:ping")
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)