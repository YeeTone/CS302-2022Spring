
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pwd.h>
#include <ctype.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include "memory.h"

#define boolean int
#define TRUE 1
#define FALSE 0
#define INPUT_BUFFERSIZE 1024
#define usernameLength 64
#define hostnameLength 64
#define workSpaceLength 128
#define msleep(x) usleep(x*1000)

char *username = NULL;
char *hostname = NULL;
char *currentWorkSpace = NULL;
char *outputWorkSpace = NULL;

char *inputCommand = NULL;

char *initEmptyString(int length) {
    char *str = malloc(sizeof(char) * length);
    memset(str, 0, sizeof(char) * length);
    return str;
}

void getusername() {
    struct passwd *pwd = getpwuid(getuid());
    strcpy(username, pwd->pw_name);
}

boolean isSameUser() {
    int length = (int) strlen(username);

    boolean same = TRUE;
    char *expectedFirst = "/home/";
    for (int i = 0; i < 6; ++i) {
        if (tolower(currentWorkSpace[i]) != tolower(expectedFirst[i])) {
            same = FALSE;
            break;
        }
    }

    if (!same) {
        return FALSE;
    }

    for (int i = 6; i < 6 + length && i < strlen(currentWorkSpace); ++i) {
        if (tolower(username[i - 6]) != tolower(currentWorkSpace[i])) {
            same = FALSE;
            break;
        }
    }

    return same;
}

int readLine(char *buff, int bufferSize) {
    memset(buff, 0, sizeof(char) * bufferSize);
    int c = 0;
    int length = 0;

    while ((c = getchar()) != EOF && length < bufferSize) {

        if (c == '\n') {
            break;
        }
        buff[length++] = (char) c;
    }

    buff[length] = '\0';
    return length;
}

void setOutputWorkSpace() {
    if (isSameUser()) {
        outputWorkSpace[0] = '~';
        int delta = (int) strlen(username) + 6;
        strcpy(outputWorkSpace + 1, currentWorkSpace + delta);
    } else {
        strcpy(outputWorkSpace, currentWorkSpace);
    }
}

boolean checkInputLine(char *inputLine) {
    char *validCommands[] = {"cd", "ps", "ls",
                             "pwd", "exit", "touch",
                             "mkdir", "rm"};

    int firstBlankIndex = -1;

    boolean nonBlank = FALSE;
    int nonBlankStart = 0;
    for (int i = 0; i < strlen(inputLine); ++i) {
        if (inputLine[i] == ' ') {
            if (nonBlank) {
                firstBlankIndex = i;
                break;
            }
        } else {
            if (!nonBlank) {
                nonBlank = TRUE;
                nonBlankStart = i;
            }

        }
    }

    if (!nonBlank) {
        return FALSE;
    }

    if (firstBlankIndex == -1) {
        firstBlankIndex = strlen(inputLine);
        nonBlankStart = 0;
    }

    boolean fit = FALSE;
    for (int i = 0; i < sizeof(validCommands) / sizeof(char *); ++i) {
        if (strlen(validCommands[i]) != firstBlankIndex - nonBlankStart) {
            continue;
        }

        boolean tempFit = TRUE;
        for (int j = nonBlankStart; j < firstBlankIndex; ++j) {
            if (validCommands[i][j - nonBlankStart] != inputLine[j]) {
                tempFit = FALSE;
                break;
            }
        }

        if (tempFit) {
            fit = TRUE;
            break;
        }
    }

    if (!fit) {
        memset(inputCommand, 0, sizeof(char) * strlen(inputCommand));
        memcpy(inputCommand, inputLine + nonBlankStart,
               sizeof(char) * (firstBlankIndex - nonBlankStart));
    }

    return fit;
}

boolean judgeCD(char *inputLine) {
    if (strncasecmp(inputLine, "cd", 2) == 0) {
        char *restPath = initEmptyString(INPUT_BUFFERSIZE);
        strcpy(restPath, inputLine + strlen("cd") + 1);

        if (strlen(restPath) == 0 ||
        (strlen(restPath) == 1 && restPath[0] == '~')) {
            chdir(getenv("HOME"));
        } else {
            if (chdir(restPath) != 0) {
                printf("cd: %s: No such file or directory!\n", restPath);
            }

        }

        free(restPath);
        restPath = NULL;
        return TRUE;
    }

    return FALSE;
}

boolean judgeTouch(char *inputLine) {
    if (strncasecmp(inputLine, "touch", 5) == 0) {
        char *restPath = initEmptyString(INPUT_BUFFERSIZE);
        strcpy(restPath, inputLine + strlen("touch") + 1);

        if (strlen(restPath) == 0) {
            printf("Missing File Name Parameter!\n");
        } else {

            FILE *fileP = fopen(restPath, "r");
            if (fileP == NULL) {
                fileP = fopen(restPath, "w");
                if (fileP == NULL) {
                    printf("touch: %s: Cannot create file!\n", restPath);
                }
            }

            fclose(fileP);

            fileP = NULL;


        }
        free(restPath);
        restPath = NULL;
        return TRUE;
    }

    return FALSE;
}

boolean judgeMkdir(char *inputLine) {
    if (strncasecmp(inputLine, "mkdir", 5) == 0) {
        char *restPath = initEmptyString(INPUT_BUFFERSIZE);
        strcpy(restPath, inputLine + strlen("mkdir") + 1);

        if (strlen(restPath) == 0) {
            printf("Missing Directory Name Parameter!\n");
        } else {

            if (mkdir(restPath, S_IRWXU | S_IRGRP |
            S_IWGRP | S_IROTH) == 0) {
                printf("mkdir: %s: Directory is created successfully.\n"
                       , restPath);
            } else {
                printf("create file error!\n");
            }

        }
        free(restPath);
        restPath = NULL;
        return TRUE;
    }

    return FALSE;
}

boolean judgeRM(char *inputLine) {
    if (strncasecmp(inputLine, "rm", 2) == 0) {
        char *restPath = initEmptyString(INPUT_BUFFERSIZE);
        strcpy(restPath, inputLine + strlen("rm") + 1);

        if (strlen(restPath) == 0) {
            printf("Missing File Name Parameter!\n");
        } else {

            if (remove(restPath) == 0) {
                printf("rm successfully.\n");
            } else {
                printf("rm error!\n");
            }

        }
        free(restPath);
        restPath = NULL;
        return TRUE;
    }

    return FALSE;
}

int main() {

    username = initEmptyString(usernameLength);
    hostname = initEmptyString(hostnameLength);
    currentWorkSpace = initEmptyString(workSpaceLength);
    outputWorkSpace = initEmptyString(workSpaceLength);
    inputCommand = initEmptyString(workSpaceLength);

    getusername();
    gethostname(hostname, hostnameLength);


    char *inputLine = initEmptyString(INPUT_BUFFERSIZE);

    while (TRUE) {
        getcwd(currentWorkSpace, workSpaceLength);
        setOutputWorkSpace();
        printf("%s@%s:%s ", username, hostname, outputWorkSpace);
        readLine(inputLine, INPUT_BUFFERSIZE);

        if (!checkInputLine(inputLine)) {
            printf("No such command: %s\n", inputCommand);
            continue;
        }

        if (strncasecmp(inputLine, "exit", 4) == 0) {
            break;
        }

        if (judgeCD(inputLine)) {
            continue;
        }

        if (judgeTouch(inputLine)) {
            continue;
        }

        if (judgeMkdir(inputLine)) {
            continue;
        }

        if (judgeRM(inputLine)) {
            continue;
        }

        char *strs[] = {"ps", "ls", "pwd"};

        for (int i = 0; i < sizeof(strs) / sizeof(char *); ++i) {
            if (strncasecmp(inputLine, strs[i], strlen(strs[i])) == 0) {

                char *temp = initEmptyString(INPUT_BUFFERSIZE);

                strcpy(temp, inputLine + strlen(strs[i]) + 1);

                printf("%s", temp);

                if (fork() == 0) {

                    if (strlen(temp) == 0) {
                        if (strs[i][0] == 'l' && strs[i][1] == 's') {
                            execlp(strs[i], strs[i], currentWorkSpace, NULL);
                        } else {
                            execlp(strs[i], strs[i], NULL);
                        }

                    } else {
                        execlp(strs[i], strs[i], temp, NULL);
                    }

                } else {
                    wait(NULL);
                }

                free(temp);
                temp = NULL;
            }
        }


    }

    free(username);
    username = NULL;
    free(hostname);
    hostname = NULL;
    free(currentWorkSpace);
    currentWorkSpace = NULL;
    free(outputWorkSpace);
    outputWorkSpace = NULL;
    free(inputCommand);
    inputCommand = NULL;
    free(inputLine);
    inputLine = NULL;

    return EXIT_SUCCESS;
}
