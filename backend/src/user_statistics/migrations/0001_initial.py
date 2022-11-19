# Generated by Django 4.1.1 on 2022-10-01 19:12

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='UserStatistics',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('total_count', models.IntegerField(default=0)),
                ('healthy_count', models.IntegerField(default=0)),
                ('pneunomia_count', models.IntegerField(default=0)),
                ('tuberculosis_count', models.IntegerField(default=0)),
                ('covid_count', models.IntegerField(default=0)),
                ('total_correct_count', models.IntegerField(default=0)),
                ('healthy_correct_count', models.IntegerField(default=0)),
                ('pneunomia_correct_count', models.IntegerField(default=0)),
                ('tuberculosis_correct_count', models.IntegerField(default=0)),
                ('covid_correct_count', models.IntegerField(default=0)),
            ],
        ),
    ]
