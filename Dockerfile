FROM public.ecr.aws/lambda/python:3.12

ENV FONTCONFIG_PATH="/opt/fonts"
ENV LD_LIBRARY_PATH="/opt/lib/"

COPY wkhtmltox/. /opt/
RUN chmod +x /opt/bin/wkhtmltopdf
RUN chmod -R 755 /opt/lib
RUN chmod -R 755 /opt/fonts

