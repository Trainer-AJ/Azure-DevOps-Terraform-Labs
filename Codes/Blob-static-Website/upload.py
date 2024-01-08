from azure.identity import DefaultAzureCredential 
import os
from azure.storage.blob import BlobServiceClient
# connection_string = "<your_storage_account_connection_string>"
container_name = "$web"
file_extensions = [".html", ".css", ".js"]

credential = DefaultAzureCredential()

# blob_service_client = BlobServiceClient.from_connection_string(connection_string)
blob_service_client = BlobServiceClient()
container_client = blob_service_client.get_container_client(container_name)

for root, dirs, files in os.walk("<path_to_files_directory>"):
       for file in files:
           if any(file.endswith(ext) for ext in file_extensions):
               blob_name = os.path.relpath(os.path.join(root, file), "<path_to_files_directory>")
               blob_client = container_client.get_blob_client(blob_name)
               with open(os.path.join(root, file), "rb") as data:
                   blob_client.upload_blob(data, overwrite=True)
