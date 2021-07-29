double max(double a, double b)
{
    return a > b ? a : b;
}



double power(double base, int expo)
{
    if (expo == 0)
        return 1;
    
    double result = 1.0;

    if (expo > 0) {
        for (int i = 0; i < expo; i++)
            result *= base;
    }
    else if (expo < 0) {
        for (int i = 0; i < -expo; i++)
            result /= base;
    }
    
    return result;
}
