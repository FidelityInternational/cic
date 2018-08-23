

# Contributors Guide

## Raising an issue
There are several types of issue that you can raise depending on what it is you are looking for.
- A new exercise
- A fix to a bug in an exercise or the courseware
- A new courseware feature

We've provided issue templates to help you make requests so look out for the issue type that best suits your request.

## Contributing an exercise
Exercises can consist of the following components:
- **Exercise readme**
- **Resources** - Additional bits and pieces needed to support the exercise
- **Tests** - Exercises should be accompanied by a test(s) that participants can run to prove to themselves that they have completed the task correctly
- **Test Infrastructure** - Many topics require an environment for participants to conduct the exercise within. This represent a barrier to participants especially if the environment is a complex one. CIC is built upon the philosphy that a participant should not be required to provide any infrastructure in order to carry out an exercise. CIC uses docker and docker-compose to achieve this.




### Getting started
On the command line navigate to the place where the you intend to create your new exercise. For example the, if you want to create a new exercise for ansible. Navigate to correct location within the CIC exercise directory structure and run `exercise create exercise_name`. This command will create a skeleton exercise directory with the all the files that you are likely to need.
```
Creating new exercise: exercise_name
Created: exercise_name/tests
Created: exercise_name/.templates
Created: exercise_name/.templates/README.md.erb
Created: exercise_name/resources
Created: exercise_name/.cic
Created: exercise_name/.cic/docker-compose.yml
[OK] Complete

```


### .templates
Technical exercises can be complicated to write. They are full of commands, and example output, which if slightly incorrect can cause massive confusion to the reader. Reading exercises through to ensure the accuracy of these things is time consuming and error prone.

To overcome this problem, the CIC content framework allows you to write and execute templates representing your exercise files. During the processing of your templates, commands can be verified and their output can be inserted in to the documentation that is generated for the participant.

The only requirement is that the files in the `exercise_name/.templates` directory end with the extension `.erb`. This identifies them as ERB files and that they should be picked up for processing. ERB is a markup format, however you only need to know the following to use CIC's content framework.

By default, you are given the file `exercise_name/.templates/README.md.erb`, from which the mandatory exercise README.md will be generated.

#### prescribing a command

Let's say that you want to tell your reader to execute the following command `mkdir new_directory`. To do this you would prescribe the command using some special syntax in line with the rest of the exercise content. E.g.
```ERB
  Please run the following command:  <%= command( 'mkdir new_directory') %>
```
In the above, the following is happening:
0. The helper method `command` is being invoked to run `mkdir new_directory`. `command` does two things:
  0. It runs the command for real to see if it executes successfully. If the command does not work, generation will fail. This allows you to find out early when the commands you are telling participants to run don't actually work.
  0. It returns the command you gave it so that it can be inserted in to the generated file.
0. The  <%= %> tags mean that you want the output of the `command` helper invocation to be written in to the generated file.


#### Displaying the output of a command
There are 3 ways to display the output of a command
1. Use the `command_output` helper to return the output of the command directly.
2. Use the `last_command_output` to get hold of the output from the last command you ran using either the `command` or `command_output` helpers
3. Memoisation
When you want to save the output of a command and use it after other uses of the `command` helper you can save the output against a variable and refer to that instead.
E.g.
```ERB
<% saved_command_output_variable = last_command_output %>
<%= saved_command_output_variable %>

```
#### Generating documentation

To render the documents set out in the `.templates` directory, navigate to the root of your exercise directory and run `exercise generate`. This will should give output like the following:
```
#############################
# Generating exercise files #
#############################
Generating file for: README.md.erb
[OK] Finished: README.md.erb

```

Files produced by the templates will be put in to the root of the exercise directory relative to their locations within the templates directory.

### resources
You will often want to supply resources to support your exercise. Put these files within the resources directory.

### .cic/docker-compose.yml: Test infrastructure
Some exercises will require some kind of test infrastructure to for participants to run their exercise code against. The `cic up` wraps docker-compose to stand up the infrastructure you prescribe in blah



  

Revision: f32616a772305aa2d9c8759c2927018e3c36c40e718e4fc1c9ada2024bb72ad6