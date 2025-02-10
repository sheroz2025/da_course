def factorial(n, method="iterative"):
    if method == "iterative":
        result = 1
        for i in range(1, n + 1):
            result *= i
        return result
    else:
        # Placeholder for recursive method
    if method == "recursive":
        if n == 0 or n == 1:
            return 1
        else:
            return n * factorial(n - 1, method="recursive")
if __name__ == "__main__":
    number = 5
    method = input("Choose method (iterative/recursive): ").strip().lower()
    print(f"Factorial of {number} is {factorial(number, method)}")

<<<<<<< HEAD
if __name__ == "__main__":
    number = 5
    method = input("Choose method (iterative/recursive): ").strip().lower()
    print(f"Factorial of {number} is {factorial(number, method)}")
=======
def factorial(n, method="iterative"):
    if method == "recursive":
        if n == 0 or n == 1:
            return 1
        else:
            return n * factorial(n - 1, method="recursive")
    else:
        # Placeholder for iterative method
        pass

if __name__ == "__main__":
    number = 5
    method = input("Choose method (iterative/recursive): ").strip().lower()
    print(f"Factorial of {number} is {factorial(number, method)}")
>>>>>>> feature/recursive
