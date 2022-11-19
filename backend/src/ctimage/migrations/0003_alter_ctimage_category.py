# Generated by Django 4.1.1 on 2022-11-19 12:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ctimage', '0002_alter_ctimage_category'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ctimage',
            name='category',
            field=models.CharField(choices=[('healthy', 'Healthy'), ('pneumonia', 'Pneumonia'), ('tuberculosis', 'Tuberculosis'), ('covid', 'Covid'), ('edema', 'Edema'), ('lesion', 'Lung Lesion')], max_length=100),
        ),
    ]