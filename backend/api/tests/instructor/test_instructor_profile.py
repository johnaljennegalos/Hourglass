from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase, APIClient
from django.contrib.auth import get_user_model

from api.models import ConsultationSlot, ConsultationBooking


User = get_user_model()

class InstructorProfileTest(APITestCase):
    def setUp(self):
        self.instructor_a = User.objects.create_user(
            role='IN',
            username='insa',
            email='insa@test.com',
            department='CS',
            specialization='Backend'
        )

        self.instructor_b = User.objects.create_user(
            role='IN',
            username='insb',
            email='insb@test.com',
            department='ENG',
            specialization='ENGLISH 1'
        )

        self.student = User.objects.create_user(
            role='ST',
            username='stud',
            email='stud@test.com',
        )

        self.url = reverse('instructor-profile')

        self.client = APIClient()

    def test_retrieve_own_profile(self):
        self.client.force_authenticate(user=self.instructor_a)

        response = self.client.get(self.url)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['id'], self.instructor_a.id)
        self.assertEqual(response.data['email'], self.instructor_a.email)
        self.assertEqual(response.data['department'], self.instructor_a.department)
        self.assertEqual(response.data['specialization'], self.instructor_a.specialization)

    def test_update_own_profile_success_and_read_only_protection(self):
        self.client.force_authenticate(user=self.instructor_a)

        payload = {
            'department' : 'IT',
            'specialization' : 'Machine Learning',
            'role' : 'AD',
            'email' : 'hacked@test.com'
        }

        response = self.client.patch(self.url, data=payload)
        print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.instructor_a.refresh_from_db()
        self.assertEqual(response.data['department'], self.instructor_a.department)
        self.assertEqual(response.data['specialization'], self.instructor_a.specialization)
        self.assertEqual(response.data['role'], self.instructor_a.role)
        self.assertEqual(response.data['email'], self.instructor_a.email)

    def test_profile_permissions_and_tenant_barriers(self):
        self.client.force_authenticate(user=self.student)
        student_response = self.client.get(self.url)
        self.assertEqual(student_response.status_code, status.HTTP_403_FORBIDDEN)

        self.client.logout()
        unauth_response = self.client.get(self.url)
        self.assertEqual(unauth_response.status_code, status.HTTP_401_UNAUTHORIZED)

        self.client.force_authenticate(user=self.instructor_b)
        response = self.client.get(self.url)
        self.assertEqual(response.data['id'], self.instructor_b.id)

