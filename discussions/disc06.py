# Discussion 6: Generators

# Q1: Big Fib
def gen_fib():
    n, add = 0, 1
    while True:
        yield n
        n, add = n + add, n

def res():
    """Complete the expression below by writing only names and parentheses 
    in the blanks so that it evaluates to the smallest Fibonacci number that 
    is larger than 2024.
    
    >>> res()
    2584
    """
    "*** YOUR CODE HERE ***"
    return next(filter(lambda n: n > 2024, gen_fib()))




# Q2: Something Different
def differences(t):
    """Yield the differences between adjacent values from iterator t.

    >>> list(differences(iter([5, 2, -100, 103])))
    [-3, -102, 203]
    >>> next(differences(iter([39, 100])))
    61
    """
    "*** YOUR CODE HERE ***"
    pre_num = None
    for num in t:
        if pre_num != None:
            yield num - pre_num
        pre_num = num




# Q3: Partitions
def partition_gen(n, m):
    """Yield the partitions of n using parts up to size m.

    >>> for partition in sorted(partition_gen(6, 4)):
    ...     print(partition)
    1 + 1 + 1 + 1 + 1 + 1
    1 + 1 + 1 + 1 + 2
    1 + 1 + 1 + 3
    1 + 1 + 2 + 2
    1 + 1 + 4
    1 + 2 + 3
    2 + 2 + 2
    2 + 4
    3 + 3
    """
    assert n > 0 and m > 0
    if n == m:
        yield str(m)
    if n - m > 0:
        "*** YOUR CODE HERE ***"
        for p in partition_gen(n - m, m):
            yield p + ' + ' + str(m)
    if m > 1:
        "*** YOUR CODE HERE ***"
        yield from partition_gen(n, m - 1)




def partition_gen_list(n, m):
    """List the partitions of n using parts up to size m.

    >>> for partition in sorted(partition_gen_list(6, 4)):
    ...     print(partition)
    1 + 1 + 1 + 1 + 1 + 1
    1 + 1 + 1 + 1 + 2
    1 + 1 + 1 + 3
    1 + 1 + 2 + 2
    1 + 1 + 4
    1 + 2 + 3
    2 + 2 + 2
    2 + 4
    3 + 3
    """
    assert n > 0 and m > 0
    exact_match, with_m, without_m = [], [], []
    if n == m:
        exact_match = [str(m)]
    if n - m > 0:
        "*** YOUR CODE HERE ***"
        with_m = [p + ' + ' + str(m) for p in partition_gen_list(n - m, m)]
    if m > 1:
        "*** YOUR CODE HERE ***"
        without_m = partition_gen_list(n, m - 1)
    return exact_match + with_m + without_m
