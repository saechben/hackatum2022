from django.contrib import admin
from .models import CTImage

class CTImageAdmin(admin.ModelAdmin):
    list_filter = [
         "category",
    ]
    search_fields = (
        "image_url",
    )
# Register your models here.
admin.site.register(CTImage, CTImageAdmin)