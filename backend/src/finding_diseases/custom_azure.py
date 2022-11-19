from storages.backends.azure_storage import AzureStorage

class AzureMediaStorage(AzureStorage):
    account_name = 'djangoctimages' # Must be replaced by your <storage_account_name>
    account_key = 'cwht/31i94iqJRSAaTHyLwNWT8kUSkXCtROtyajbugzUjUC3VQydu/ZMJb2UQOJ43vHeaAwm9DxB+AStAlklBA==' # Must be replaced by your <storage_account_key>
    azure_container = 'media'
    expiration_secs = None

class AzureStaticStorage(AzureStorage):
    account_name = 'djangoctimages' # Must be replaced by your storage_account_name
    account_key = 'cwht/31i94iqJRSAaTHyLwNWT8kUSkXCtROtyajbugzUjUC3VQydu/ZMJb2UQOJ43vHeaAwm9DxB+AStAlklBA==' # Must be replaced by your <storage_account_key>
    azure_container = 'static'
    expiration_secs = None