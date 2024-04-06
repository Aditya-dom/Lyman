from django.db import models


# Create your models here.

class Defi(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name
    
# Path: mydefi/defi/forms.py
from django import forms
from .models import Defi

class DefiForm(forms.ModelForm):
    class Meta:
        model = Defi
        fields = ['name', 'description']

# Path: mydefi/defi/views.py    
        
from django.shortcuts import render, redirect
from .models import Defi
from .forms import DefiForm

# Create your views here.

def defi_list(request):
    defis = Defi.objects.all()
    return render(request, 'defi/defi_list.html', {'defis': defis})

def defi_detail(request, pk):
    defi = Defi.objects.get(pk=pk)
    return render(request, 'defi/defi_detail.html', {'defi': defi})

def defi_create(request):

    if request.method == 'POST':
        form = DefiForm(request.POST)
        if form.is_valid():
            defi = form.save()
            return redirect('defi_detail', pk=defi.pk)
    else:
        form = DefiForm()
    return render(request, 'defi/defi_form.html', {'form': form})

# Path: mydefi/defi/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.defi_list, name='defi_list'),
    path('defis/<int:pk>/', views.defi_detail, name='defi_detail'),
    path('defis/new/', views.defi_create, name='defi_create'),
]

# Path: mydefi/defi/urls.py

from django.urls import path
from . import views

