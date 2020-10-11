/*
  Implements a minimal shell.  The shell simply finds executables by
  searching the directories in the PATH environment variable.
  Specified executable are run in a child process.

  AUTHOR: Chi Nguyen
  ln2569@bard.edu
  3/7/2020
  Assignment 4
  I worked with tutor Sam on this assignment.


*/

#include "bshell.h"
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>


int parsePath(char *dirs[]);
char *lookupPath(char *fname, char **dir,int num);
int parseCmd(char *cmdLine, Command *cmd);

/*
  Read PATH environment var and create an array of dirs specified by PATH.

  PRE: dirs allocated to hold MAX_ARGS pointers.
  POST: dirs contains null-terminated list of directories.
  RETURN: number of directories.

  NOTE: Caller must free dirs[0] when no longer needed.

*/
int parsePath(char *dirs[]) {
  int i, numDirs=0;
  char *pathEnv;
  char *thePath;
  char *nextcharptr; /* point to next char in thePath */
  
  for (i = 0; i < MAX_PATHS; i++) dirs[i] = NULL;
  pathEnv = (char *) getenv("PATH");
  
  if (pathEnv == NULL) return 0; /* No path var. That's ok.*/
  int len = strlen(pathEnv); //length of pathEnv
  /*Declare memory space for the Path */
  thePath = (char*) malloc((sizeof(char)*len)+1);
  /* for safety copy from pathEnv into thePath */
  
  strcpy(thePath,pathEnv);
  

#ifdef DEBUG
  printf("Path: %s\n",thePath);
#endif

  /* Now parse thePath */
  nextcharptr = thePath;

  /* 
     Find all substrings delimited by DELIM.  Make a dir element
     point to each substring.
     TODO: approx a dozen lines.
  */
    char* temp =strtok(thePath,DELIM);
    while(temp !=NULL){
      dirs[numDirs]=temp;
      numDirs++;
      if(numDirs >=MAX_PATHS) break;
      temp = strtok(NULL,DELIM);
    }
    
  /* Print all dirs */
#ifdef DEBUG
  for (i = 0; i < numDirs; i++) {
    printf("%s\n",dirs[i]);
  }
#endif
    
  return numDirs;
}


/*
  Search directories in dir to see if fname appears there.  This
  procedure is correct!

  PRE dir is valid array of directories
  PARAMS
   fname: file name
   dir: array of directories
   num: number of directories.  Must be >= 0.

  RETURNS full path to file name if found.  Otherwise, return NULL.

  NOTE: Caller must free returned pointer.
*/

char *lookupPath(char *fname, char **dir,int num) {
  char *fullName; // resultant name
  int maxlen; // max length copied or concatenated.
  int i;

  fullName = (char *) malloc(MAX_PATH_LEN);
  /* Check whether filename is an absolute path.*/
  if (fname[0] == '/') {
    strncpy(fullName,fname,MAX_PATH_LEN-1);
    if (access(fullName, F_OK) == 0) {
      return fullName;
    }
  }

  /* Look in directories of PATH.  Use access() to find file there. */
  else {
    for (i = 0; i < num; i++) {
      // create fullName
      maxlen = MAX_PATH_LEN - 1;
      strncpy(fullName,dir[i],maxlen);
      maxlen -= strlen(dir[i]);
      strncat(fullName,"/",maxlen);
      maxlen -= 1;
      strncat(fullName,fname,maxlen);
      // OK, file found; return its full name.
      if (access(fullName, F_OK) == 0) {
	return fullName;
      }
    }
  }
  fprintf(stderr,"%s: command not found\n",fname);
  free(fullName);
  return NULL;
}

/*
  Parse command line and fill the cmd structure.

  PRE 
   cmdLine contains valid string to parse.
   cmd points to valid struct.
  PST 
   cmd filled, null terminated.
  RETURNS arg count

  Note: caller must free cmd->argv[0..argc]

*/
int parseCmd(char *cmdLine, Command *cmd) {
  int argc = 0; // arg count
  char* token;
  int i = 0;

  token = strtok(cmdLine, SEP);
  while (token != NULL && argc < MAX_ARGS){    
    cmd->argv[argc] = strdup(token);
    token = strtok (NULL, SEP);
    argc++;
  }

  cmd->argv[argc] = NULL;  
  cmd->argc = argc;

#ifdef DEBUG
  printf("CMDS (%d): ", cmd->argc);
  for (i = 0; i < argc; i++)
    printf("CMDS: %s",cmd->argv[i]);
  printf("\n");
#endif
  
  return argc;
}

/*
  Runs simple shell.
*/
int main(int argc, char *argv[]) {

  char *dirs[MAX_PATHS]; // list of dirs in environment
  int numPaths;
  char cmdline[LINE_LEN];
  int num_of_argc;
  char input[LINE_LEN];
  Command Com;
  int job=0;
  char jobID[10],jobpid[10];
  char* jobname[10];//= malloc(sizeof(char)*10);
  int ampersand =0;
  numPaths = parsePath(dirs);
  // TODO
  while(1){
    char* curdir=getcwd(curdir,512);
    printf("%s: ",curdir);
    fgets(input,LINE_LEN,stdin);
    if(input!=NULL && input[0] != '\n'){
      //printf("%s\n",input);
      const char ex[5]="exit";
      num_of_argc = parseCmd(input,&Com);
      Com.argv[Com.argc]=NULL;
      if(strncmp(Com.argv[0],ex,5)==0){
        break;
      }//if argv[0] = exit then exit shell
      
      const char as[2]="&";
      if(strncmp(Com.argv[Com.argc-1],as,2)==0 && Com.argc>1){
        ampersand=1;
        Com.argv[Com.argc-1]=NULL;
        Com.argc=argc-1;
      } else ampersand=0;
      
      
      char* path=lookupPath(Com.argv[0],dirs,numPaths);
      const char jo[5]="jobs";
      const char cd[3]="cd";
      //cd 
      if(strncmp(Com.argv[0],cd,3)==0){
        //change current dir to home
        if(Com.argc==1){
          chdir("/home");
        } else if(Com.argc==2){
          chdir(Com.argv[1]);
        } else printf("can not find dir");
        
      } else
      //jobs
      if(strncmp(Com.argv[0],jo,5)==0){
        if(job>0)
        for(int i=0; i<job;i++) 
        printf("Job ID: %s",jobID[i],"; Job name: %s",jobname[i],"; Job PID: %s",jobpid);
      } else
      if(path!=NULL){//found a command
        pid_t pid = fork();
        if(pid==0){
          printf("Child process running\n");
          if(execv(path,Com.argv)==-1){
            perror("fail\n");
          }
        } else {
                int status;
                if(ampersand==0){
                  //parent wait for child to finish
                  while(waitpid(pid,&status,WNOHANG)<=0){
                    continue;
                  }
                  //dont wait
                } else if(ampersand==1){
                    printf("Child PID:%ld\n",(long)pid);
                    jobID[job]=job+1;
                    jobname[job]=Com.argv[0];
                    jobpid[job]=pid;
                    job++;
                }
              }
        
      } else printf("command not found\n");   
    }
  }
  ////free memory
  for (int i=0;i<Com.argc;i++) free(Com.argv[i]); 
  for(int i=0;i<numPaths;i++) free(dirs[i]);
  //free(jobname);
}
