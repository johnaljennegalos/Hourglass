from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase, APIClient
from django.contrib.auth import get_user_model

from api.models import ConsultationSlot, ConsultationBooking


User = get_user_model()

class SignInTest(APITestCase):
    def setUp(self):
        self.student = User.objects.create_user(
            role='ST',
            username='student1',
            email='stud1@test.com',
            password='studstud'
        )

        self.instructor = User.objects.create_user(
            role='IN',
            username='instructor1',
            email='ins1@test.com',
            password='insins'
        )

        self.url = reverse('sign-in')
        self.client = APIClient()

    def test_success_student_sign_in(self):
        payload = {
            'username' : 'student1',
            'password' : 'studstud'
        }
        url = self.url
        response = self.client.post(url, data=payload, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('access', response.data)
        self.assertIn('refresh', response.data)
        self.assertEqual(response.data['role'], 'ST')

    def test_success_instructor_sign_in(self):
        payload = {
            'username' : 'instructor1',
            'password' : 'insins'
        }
        url = self.url
        response = self.client.post(url, data=payload, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('access', response.data)
        self.assertIn('refresh', response.data)
        self.assertEqual(response.data['role'], 'IN')

    def test_invalid_credentials(self):
        payload = {
            'username' : 'testusername',
            'password' : 'useruser'
        }

        url = self.url
        response = self.client.post(url, data=payload, format='json')

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('error', response.data)
