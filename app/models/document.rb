class Document < ApplicationRecord

## Set the relationships between models

has_one :approval_routes

## Tells rails to use this uploader for this model using the report_form attribute to store file information

mount_uploaders :stored_doc, DocFileUploader
mount_uploaders :stored_pdf, PdfFileUploader

end
