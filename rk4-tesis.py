#A runge-kutta method example for resolving ordinay differential equation system
#From a second orden patial differential equation (Schrodinger's equation)
#Made by Hiram Ernesto Damian 
#using RK4 method 
from numpy import *
import matplotlib.pyplot as plt
from pylab import *
import matplotlib.animation as animation
#define paameters for frequencies in GHz
w=1.0
w0=1.0
w1=0.1

#define ODE system equations obtbned directly from Schrodinger's equation
#A=a+ib , B=c+id
def f(a,t):
    return 0.5*(w0*b + w1*cos(w*t)*d)
def f1(b,t):
    return  -0.5*(w0*a + w1*cos(w*t)*c)
def f2(c,t):
    return  -0.5*(w0*d - w1*cos(w*t)*b )
def f3(d,t):
    return 0.5*(w0*c - w1*cos(w*t)*a)

#initial conditions 
a = 1.0 ; c=0.0
b = 0.0 ; d=0.0
#This is where the data is saved during the Loop
apoints = []
bpoints = []
cpoints =[]
dpoints=[]
rpoints=[]
#step size 
h=0.1 #nanoseconds
#time 
tmax=200
time = arange(0,tmax,h)
#Fourth order runge-kutta algorithm (RK4) 
#Here the program generate the solution for the ODE system
for t in time:
    apoints.append(a)
    k1 = h*f(a,t)
    k2 = h*f(a+0.5*k1,t+0.5*h)
    k3 = h*f(a+0.5*k2,t+0.5*h)
    k4 = h*f(a+k3,t+h)
    a =a+ (k1+2.0*k2+2.0*k3+k4)/6.0
    bpoints.append(b)
    ky1 = h*f1(b,t)
    ky2 = h*f1(b+0.5*ky1,t+0.5*h)
    ky3 = h*f1(b+0.5*ky2,t+0.5*h)
    ky4 = h*f1(b+ky3,t+h)
    b=b+ (ky1+2.0*ky2+2.0*ky3+ky4)/6.0
    cpoints.append(c)
    kz1 = h*f2(c,t)
    kz2 = h*f2(c+0.5*kz1,t+0.5*h)
    kz3 = h*f2(c+0.5*kz2,t+0.5*h)
    kz4 = h*f2(c+kz3,t+h)
    c=c+ (kz1+2.0*kz2+2.0*kz3+kz4)/6.0
    dpoints.append(d)
    kd1 = h*f3(d,t)
    kd2 = h*f3(d+0.5*kd1,t+0.5*h)
    kd3 = h*f3(d+0.5*kd2,t+0.5*h)
    kd4 = h*f3(d+kd3,t+h)
    d=d+ (kd1+2.0*kd2+2.0*kd3+kd4)/6.0
#calculate the probability for spin down (b**2+a**2=1 for normalized state)
    r=(c**2+d**2)
    rpoints.append(r)
    print(a,b,c,d,r)

#plot the probability of spin down 
fig=figure()
plot(time,rpoints,'-g', linewidth=2,label="$p_b (t)$")
legend()
xlabel('Time (nanoseconds)')
ylabel('Probability, $p_b(t)$')
title('Probability of spin down')
ylim(0,1)
grid(True)
savefig('figure-rk4.eps')
savefig('figure-rk4.pdf')
show()
