from suds.client import Client

url="http://splegisws.camara.sp.gov.br/ws/ws2.asmx?WSDL"
client = Client(url)
print(client)
  
    
result = client.service.COLOCAR_AQUI_O_METODO()
print (result)