print('Введите значерние шага')
e=int(input())
t=2
w=10//e+1
for i in range(w):
    y=t**2
    print('x= ',t,' y= ',y)
    t+=e
    