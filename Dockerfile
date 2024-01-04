# FROM python:3.5.1-alpine
FROM python

# RUN pip install --upgrade pip
RUN pip install --upgrade setuptools wheel
RUN ls
RUN pwd
WORKDIR /opt/app
COPY ./wheeldir /opt/app/wheeldir
# These are copied and installed first in order to take maximum advantage
# of Docker layer caching (if enabled).
COPY *requirements.txt /opt/app/src/
RUN pip install --use-wheel --no-index --find-links=/opt/app/wheeldir \
    -r /opt/app/src/requirements.txt
RUN pip install --use-wheel --no-index --find-links=/opt/app/wheeldir \
    -r /opt/app/src/test-requirements.txt

COPY . /opt/app/src/
WORKDIR /opt/app/src
RUN python setup.py install

EXPOSE 5000
CMD dronedemo




# Copy requirements files separately to leverage Docker caching
# COPY requirements.txt test-requirements.txt /opt/app/src/

# Install dependencies from the pre-built wheel directory
# RUN pip install --use-wheel --no-index --find-links=/opt/app/wheeldir -r /opt/app/src/requirements.txt
# RUN pip install --use-wheel --no-index --find-links=/opt/app/wheeldir -r /opt/app/src/test-requirements.txt

# Copy the application source code
# COPY . /opt/app/src/

# Set the working directory to the source directory
# WORKDIR /opt/app/src

# Install the application
# RUN python setup.py install

# Make port 5000 available to the world outside this container
# EXPOSE 5000

# Define the command to run the application
# CMD ["dronedemo"]  # Assuming 'dronedemo' is the command to start your application
