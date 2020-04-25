#define _GNU_SOURCE
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEBUG 0

#define MAX_BRIGHTNESS "max_brightness"
#define BRIGHTNESS "brightness"
#define MAX(a, b) (a > b ? a : b)
#define MIN(a, b) (a < b ? a : b)

char *return_first(const char *dir_path) {
	 DIR *d;
  struct dirent *dir;
  d = opendir(dir_path);
  if (d) {
    while ((dir = readdir(d)) != NULL) {
		if (dir->d_type == DT_LNK) {
			char *name = malloc(strlen(dir_path) + strlen(dir->d_name) + 1);
			strcpy(name, dir_path);
			strcat(name, dir->d_name);
			closedir(d);
			return name;
		}
    }
    closedir(d);
  }
  return NULL;
}

int main(int argc, char ** argv) {

	if(argc != 3 ||
			(strcmp("inc", argv[1]) != 0 && strcmp("dec", argv[1]) != 0)) {
		fprintf(stderr, "usage: %s [inc/dec] <percent>\n", argv[0]);
		return 1;
	}

	int inc = strcmp("inc", argv[1]) == 0;
	int percent = atoi(argv[2]);

	char* name = return_first("/sys/class/backlight/");

	char *max_bright_file = malloc(strlen(name) + strlen(MAX_BRIGHTNESS) + 2);
	sprintf(max_bright_file, "%s/"MAX_BRIGHTNESS, name);
	if(DEBUG) printf("max_brightness file %s\n", max_bright_file);

	char *bright_file = malloc(strlen(name) + strlen(BRIGHTNESS) + 1);
	sprintf(bright_file, "%s/"BRIGHTNESS, name);
	if(DEBUG) printf("brightness file %s\n", bright_file);

	int max_b, curr;
	FILE *f;
	f = fopen(max_bright_file, "r");
	if (f == NULL) {
		perror("opening max_brightness file for reading");
		return 1;
	}
	fscanf(f, "%d", &max_b);
	fclose(f);
	f = fopen(bright_file, "r");
	if (f == NULL) {
		perror("opening brightness file for reading");
		return 1;
	}
	fscanf(f, "%d", &curr);
	fclose(f);

	int diff = (inc ? +1 : -1 ) * (max_b * percent)/100;
	int new = MIN(curr + diff, max_b);
	new = MAX(0, new);

	if(DEBUG) printf("current: %d, max: %d, new: %d\n", curr, max_b, new);

	f = fopen(bright_file, "w");
	if (f == NULL) {
		perror("opening brightness file for writing");
		return 1;
	}
	fprintf(f, "%d", new);
	fclose(f);

	free(name);
	free(max_bright_file);
	free(bright_file);
}
