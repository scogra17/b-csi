#include <dirent.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>

void list_entries(char[]);
void display_entry_info(char[], struct stat *);

int main(int argc, char * argv[]) {
  if(argc==1) {
    list_entries(".");
  }
  // TODO: introduce optional flags
  // For the time being, naively interpret the first positional argument, should
  // one be provided, as the path to the directory to ls
  else {
    list_entries(argv[1]);
  }
  return (0);
}

void list_entries(char path[]) {
  DIR* dirptr;
  struct dirent* direntptr;
  struct stat filestat;

  dirptr = opendir(path);
  if(dirptr == NULL){
    printf("Could not read directory\n");
    return;
  }

  while((direntptr=readdir(dirptr)))
  {
    stat(direntptr->d_name, &filestat);
    display_entry_info(direntptr->d_name, &filestat);
  }
  closedir(dirptr);
  return;
}

void display_entry_info(char name[], struct stat* t) {
  char buf[256];

  // Check if entry is directory to determine whether a trailing forward slash
  // should be added
  strcpy(buf, name);
  if ( S_ISDIR(t->st_mode) ) {
    strcat(buf, "/");
  }

  printf("%5lldB %ld  %s\n", t->st_size, t->st_mtime, buf);
}