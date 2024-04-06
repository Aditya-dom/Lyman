from django.urls import path
from django.urls import path, re_path
from . import views

urlpatterns = [
       path('api/swap/', include('mydefi.contracts.urls')),
    ]

urlpatterns = [
       path('swap/<str:token_in>/<int:desired_tokens_out>/', 
views.swap_tokens, name='swap'),
    ]
