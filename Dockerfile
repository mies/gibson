FROM ubuntu:12.10
RUN apt-get update
RUN apt-get -y install python-software-properties
RUN apt-get -y install wget
RUN apt-get -y install bzr
RUN apt-get -y install mercurial

RUN wget https://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz
RUN sudo tar -C /usr/local -xzf go1.1.2.linux-amd64.tar.gz

RUN echo "export PATH=$PATH:/usr/local/go/bin" | sudo tee -a /etc/profile
RUN rm go1.1.2.linux-amd64.tar.gz

# Set GOPATH
RUN export GOPATH="$HOME/go"
RUN echo 'export GOPATH="$HOME/go"' | sudo tee -a /etc/profile

# Adds go bin directory to path so tools
# and buils are available on the commandline
RUN export PATH="$PATH:$GOPATH/bin"
RUN echo 'export PATH="$PATH:$GOPATH/bin"' | sudo tee -a /etc/profile

# Make actual go workspace dir structure
RUN mkdir -p "$HOME/go/{src,pkg,bin}"

ADD . /src
# RUN cd /src; go build main.go
RUN cd go build main.go
EXPOSE 5000
# CMD ["./main"]
