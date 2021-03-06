FROM golang

# dependencies
RUN apt-get update
RUN apt-get install -y pkg-config libzmq3-dev build-essential python3-pip

# set up golang
ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# install gophernotes
RUN go get golang.org/x/tools/cmd/goimports
RUN go get -tags zmq_3_x github.com/gopherds/gophernotes
RUN mkdir -p ~/.ipython/kernels/gophernotes
RUN cp -r $GOPATH/src/github.com/gopherds/gophernotes/kernel/* ~/.ipython/kernels/gophernotes

# install jupyter
RUN pip3 install jupyter

EXPOSE 8888
CMD ["jupyter", "notebook"]
