from django.contrib import admin

# Register your models here.

from .models import Defi

admin.site.register(Defi)
```

### 4.2.2. Defi Model

```python
# Path: mydefi/defi/models.py
from django.db import models

# Create your models here.

class Defi(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name
```

### 4.2.3. Defi Form
    
    ```python
# Path: mydefi/defi/forms.py
from django import forms
from .models import Defi

class DefiForm(forms.ModelForm):
    class Meta:
        model = Defi
        fields = ['name', 'description']
```

### 4.2.4. Defi Views
    
    ```python
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
```

### 4.2.5. Defi Templates

```html
# Path: mydefi/templates/defi/defi_list.html
<!DOCTYPE html>
<html>
<head>
    <title>Defi List</title>
</head>
<body>
    <h1>Defi List</h1>
    <ul>
        {% for defi in defis %}
            <li><a href="{% url 'defi_detail' defi.pk %}">{{ defi.name }}</a></li>
        {% endfor %}
    </ul>
    <a href="{% url 'defi_create' %}">Create Defi</a>
</body>
</html>
