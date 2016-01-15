# line-server problem
## About this coding exercise

In this exercise, you will build and document a system that is capable of serving lines out of a file to network clients. You may do this in any language (although Ruby, Java, JavaScript, or Scala are preferred). You may use any reference and any open-source software you can find to help you build this system, so long as you document your use. However, you should not actively collaborate with others.

## Questions

* How does your system work? (if not addressed in comments in source)

.. I used rails and two rake tasks to build the system. The first rake task (`rake data:generate`) creates a sample file with n lines and m words per line and saves the file to the tmp/data folder. The second rake task (`rake preprocessor:preprocess`) finds or creates a Document based on the filename and destroys all lines previously associated with that document, if it previously existed. It then reads the file line by line creating a new line record in the database (either using raw SQL or active record). A lines controller then serves the line as json using a jbuilder file.

* How will your system perform with a 1 GB file? a 10 GB file? a 100 GB file?

.. Using active record, I got O(n) memory usage, and given constrained memory, I saw what looked like exponential time execution. This is a limitation of ActiveRecord, which retains objects in memory even if you nullify references to them. I considered several options to achieve a desired O(k) memory usage and order O(n*log(n)) time: 1) break up file into sub-files and process them in separate jobs. 2) use ActiveRecord connection to create records in a way where references can be dropped.

.. I went with option 2, because setting up a job infrastructure for processing each batch from file being ingested seemed to be beyond the scope of this excercise and would add additional complexity. By using sql connection, I was able to add a few lines of code and achieve good performance. Memory is constant because for each line, the memory for the query executed is recycled. It is O(n*log(n)) because n lines are processed and each insert takes constant time plus log(n) time to update the b-trees which are the default data structures of the indices.

* How will your system perform with 100 users? 10000 users? 1000000 users?

* What documentation, websites, papers, etc did you consult in doing this assignment?

* What third-party libraries or other tools does the system use? How did you choose each library or framework you used?

* How long did you spend on this exercise? If you had unlimited more time to spend on this, how would you spend it and how would you prioritize each item?

* If you were to critique your code, what would you have to say about it?

* The remainder of the files in your tree should be the source-code for your system.

## Specification

Your system should act as a network server that serves individual lines of an immutable text file over the network to clients using the following simple REST API:

GET /lines/<line index>
Returns an HTTP status of 200 and the text of the requested line or an HTTP 413 status if the requested line is beyond the end of the file.
Your server should support multiple simultaneous clients.

The system should perform well for small and large files.

The system should perform well as the number of GET requests per unit time increases.

You may pre-process the text file in any way that you wish so long as the server behaves correctly.

The text file will have the following properties:

Each line is terminated with a newline ("\n").
Any given line will fit into memory.
The line is valid ASCII (e.g. not Unicode).

## What to submit

You should submit a zip file or provide access to a public source code repository that contains shell scripts to build and run your system, documentation for your system, and the source code for the system itself.

build.sh - A script that can be invoked to build your system. This script may exit without doing anything if your system does not need to be compiled. You may invoke another tool such as Maven, Ant, etc. with this script. You may download and install any libraries or other programs you feel are necessary to help you build your system.

run.sh - A script that takes a single command-line parameter which is the name of the file to serve. Ultimately, it should start the server you have built.

README - This readme with questions section filled out.