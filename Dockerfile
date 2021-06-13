FROM python:3.9-slim as builder

RUN pip install -q poetry

WORKDIR /usr/src/APP_NAME

COPY . /usr/src/APP_NAME/
RUN poetry build -f wheel


FROM python:3.9-slim as production

COPY --from=builder /usr/src/APP_NAME/dist/APP_NAME-*.whl /usr/src/APP_NAME/
RUN pip install -q /usr/src/APP_NAME/APP_NAME-*.whl && rm -f /usr/src/APP_NAME/APP_NAME-*.whl

CMD ["/bin/bash"]
