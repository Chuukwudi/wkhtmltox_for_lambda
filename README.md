# wkhtmltox_for_lambda

Lambda compatible runtime for dockerising wkhtmltox. Current versions online even from wkhtmltopdf official repo are riddled with dependency issues and require loads of tinkering. In this repo, that tinkering has been done for you.

## Overview

This project provides a Dockerised runtime environment for using `wkhtmltox` (which includes `wkhtmltopdf` and `wkhtmltoimage`) on AWS Lambda. This setup allows you to convert HTML to PDF or images within a dockerised Lambda function.

## Paths

- `wkhtmltopdf_path`: `/opt/bin/wkhtmltopdf`
- `wkhtmltoimage_path`: `/opt/bin/wkhtmltoimage`

These paths are set up to be used within the Lambda environment.

## Usage with pdfkit

If you are using the [pdfkit](https://pypi.org/project/pdfkit/) library in Python, you can configure it to use the `wkhtmltopdf` binary provided in this Docker image.

### Example

First, install `pdfkit` and its dependencies:
```sh
pip install pdfkit
```

```python
Then, you can use the following configuration in your Python code:
import pdfkit

# Configuration for pdfkit to use the wkhtmltopdf binary
config = pdfkit.configuration(wkhtmltopdf='/opt/bin/wkhtmltopdf')

# Convert HTML string to PDF
html_string = "<h1>Hello, World!</h1>"
output_file = "/tmp/output.pdf"
pdfkit.from_string(html_string, output_file, configuration=config)
```
Your dockerfile should contain the following:

```Dockerfile
FROM public.ecr.aws/lambda/python:3.12

ENV FONTCONFIG_PATH="/opt/fonts"
ENV LD_LIBRARY_PATH="/opt/lib/"

COPY wkhtmltox/. /opt/
RUN chmod +x /opt/bin/wkhtmltopdf
RUN chmod -R 755 /opt/lib
RUN chmod -R 755 /opt/fonts
```
## IMPORTANT

If you have set up gitignore, do not add the /lib to gitignore, especially if you have set up CI CD via github actions. Otherwise the `wkhtmltox/lib` folder in will be omitted and will not ship alongside your package.

### License
This project is licensed under the MIT License.