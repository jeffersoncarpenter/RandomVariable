# RandomVariable
MatLab package for error propagation

Example:

```
x = RandomVariable(3, 4^2)
y = RandomVariable(4, 5^2)
z = x * y

a = 2^x
```

## Introduction Rules

```
randomVar = RandomVariable(mean, variance)
```

## Elimination Rules

```
mean = randomVar.value()
variance = randomVar.variance()
```

## TODO

Cover the space of allowed matlab operators.
