# line-server problem
## About this coding exercise

In this exercise, you will build and document a system that is capable of serving lines out of a file to network clients. You may do this in any language (although Ruby, Java, JavaScript, or Scala are preferred). You may use any reference and any open-source software you can find to help you build this system, so long as you document your use. However, you should not actively collaborate with others.

## Questions

* How does your system work? (if not addressed in comments in source)

⋅⋅ I used rails and two rake tasks to build the system. The first rake task (`rake data:generate`) creates a sample file with n lines and m words per line and saves the file to the tmp/data folder. The second rake task (`rake preprocessor:preprocess`) finds or creates a Document based on the filename and destroys all lines previously associated with that document, if it previously existed. It then reads the file line by line creating a new line record in the database (either using raw SQL or active record). A lines controller then serves the line as json using a jbuilder file.

* How will your system perform with a 1 GB file? a 10 GB file? a 100 GB file?

⋅⋅ Using active record, I got O(n) memory usage, and given constrained memory, I saw what looked like exponential time execution. This is a limitation of ActiveRecord, which retains objects in memory even if you nullify references to them. I considered several options to achieve a desired O(k) memory usage and order O(n*log(n)) time: 1) break up file into sub-files and process them in separate jobs. 2) use ActiveRecord connection to create records in a way where references can be dropped.

⋅⋅ I went with option 2, because setting up a job infrastructure for processing each batch from file being ingested seemed to be beyond the scope of this excercise and would add additional complexity. By using sql connection, I was able to add a few lines of code and achieve good performance. Memory is constant because for each line, the memory for the query executed is recycled. It is O(n*log(n)) because n lines are processed and each insert takes constant time plus log(n) time to update the b-trees which are the default data structures of the indices.

* How will your system perform with 100 users? 10000 users? 1000000 users?

⋅⋅ I selected puma as the server and used the default of up to 16 threads. This enables great performance from each server instance. The app layer for this code can be scaled out. I have used Heroku for this in the past. On Heroku, using a default process count of 2 and default thread count of 5, with 100 dynos, the system would theoretically be able to handle `2*5*100=1000` simultaneous requests which would enable a high multiple of 1000 users. The limiting factor would likely be # of database connections. Followers could be added to a Postgres instance to scale database connections.

* What documentation, websites, papers, etc did you consult in doing this assignment?

⋅⋅ I used StackOverflow for some refreshers. I also referred to the RSpec site to remind myself of RSpec best practices. I looked at Heroku Puma documentation for cluster defaults. I also Googled around quite a bit (to no avail) to see if there was a way to force Rails to forget ActiveRecord objects that had recently been found.

* What third-party libraries or other tools does the system use? How did you choose each library or framework you used?

⋅⋅ The only libraries I used outside of the default Rails 4.2.5 setup were RSpec, Puma, and Pry.

⋅⋅ I chose Rails because it seemed the most relevant to Salsify. I chose RSpec, because I like the it/describe DSL and wanted to brush up on some RSpec syntax since that is also relevant to Salsify. I chose Puma because of the requirement that: Your server should support multiple simultaneous clients.

* How long did you spend on this exercise? If you had unlimited more time to spend on this, how would you spend it and how would you prioritize each item?

⋅⋅ I spent most of an afternoon and evening on it. If I had more time, I would have worked on:
⋅⋅ 1. Testing how many clients it can server at once using something like the Heroku Blitz add-on
⋅⋅ 1. Breaking up large files and processing each file in a delayed job. This would enable testing with super large files more easily.

* If you were to critique your code, what would you have to say about it?

⋅⋅ 1. Some helper methods in the lines_controller should be abstracted to a concern
⋅⋅ 1. I would need to make sure test coverage was more complete
⋅⋅ 1. My tests hit the database, I would want to add stubbing (or potentially mocks). If I were building this in a team/production system, I would need to learn the testing practices of the team (eg. Stance on mocks/stubs, stance on concerns, stance on shoulda/expectations/etc.). Testing conventions vary widely between teams.

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