#include <stdio.h>
#include <sys/stat.h>
#include <errno.h>
#include <syslog.h>

int main(int argc, char* argv[])
{
    openlog(__FILE__, LOG_PID | LOG_CONS, LOG_USER);

    /* Exits with return value 1 error and print statements if any of the parameters above were not specified */
    if (argc < 3)
    {
        syslog(LOG_ERR, "missing arguments. usage: writer <writefile> <writestr>");
        closelog();
        
        return 1;
    }

    char *writefile = argv[1];
    char *writestr = argv[2];

    syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);

    FILE *fp = fopen(writefile, "w");

    /* Exits with value 1 and error print statement if the file could not be created. */
    if (fp == NULL)
    {
        syslog(LOG_ERR, "Unable to create file %s. status: %d", writefile, errno);
        perror("fopen");

        return 1;
    }

    /* Exits with value 1 and error print statement if the file could not be created. */
    if (fprintf(fp, "%s\n", writestr) < 0) 
    {
        syslog(LOG_ERR, "Unable to write to file %s. status: %d", writefile, errno);
        perror("fprintf");
        fclose(fp);

        return 1;
    }

    fclose(fp);
    closelog();

    return 0;
}