from django.http import HttpResponse

def hello(request):
    return HttpResponse("Hello, Dockerized Django App!")

