def fib(n:int):
    prev = 1
    cur = 1
    print(1,cur,hex(cur))
    for i in range(2,n):
        print(i,cur,hex(cur))
        tprev = prev
        prev = cur
        cur = tprev + cur
    print(n,cur,hex(cur))

