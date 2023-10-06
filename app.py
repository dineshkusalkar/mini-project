
from flask import Flask, render_template, request, redirect
from flask_sqlalchemy import SQLAlchemy
from azure.identity import ClientSecretCredential
from azure.keyvault.secrets import SecretClient
import os

# Get the environment variable to determine the Key Vault URL


# Now, use the 'keyvault_url' variable in your application as needed.
app = Flask(__name__)

# Configure your Azure Key Vault details

secret_name_db_username = 'username'
secret_name_db_password = 'user-password'

def get_secret(secret_name):
    key_vault_url = os.environ.get("keyvault_url")

    credential = ClientSecretCredential(                                                                           # below details are reffer from {example-app} service principle
        tenant_id= os.environ.get("tenant_id"),
        client_id= os.environ.get("client_id"),                                         #'fbc85d1a-63e6-43b1-b528-35f30e561182',                          
        client_secret= os.environ.get("client_secret")                                                                #'BJn8Q~JWDcGiUWSR6xkGII~_0WD6bkmNHBuxQbe_'                       #'56-8Q~fiieMS4OtiiCHRBAzXfQgrlaeq3wVTobA_'     
    )
    secret_client = SecretClient(vault_url=key_vault_url, credential=credential)


        # o/p is in key-value formate
    secret = secret_client.get_secret(secret_name)
    return secret.value

# Configure your MySQL database connection using secrets from Azure Key Vault
username = get_secret(secret_name_db_username)
password = get_secret(secret_name_db_password)


                                                               
db_uri = f'mysql+mysqlconnector://{username}:{password}@db-server:3306/dineshdb'
app.config['SQLALCHEMY_DATABASE_URI'] = db_uri


db = SQLAlchemy(app)

class Patient(db.Model):
    __tablename__ = 'patient'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    symptoms = db.Column(db.Text, nullable=False)

# Create the table
with app.app_context():
    db.create_all()


# define root for web application
@app.route('/', methods=['GET', 'POST'])
def submit():
    if request.method == 'POST':
        # fetch the form data
        userDetails = request.form
        name = userDetails['name']
        age = userDetails['age']
        gender = userDetails['gender']
        symptoms = userDetails['symptoms']

        new_patient = Patient(name=name, age=age, gender=gender, symptoms=symptoms)

        # Add the patient to the database
        with app.app_context():
          db.session.add(new_patient)
          db.session.commit()

        return redirect('/patient_list')
    
    return render_template('patient_form.html')

@app.route('/patient_list', methods=['GET'])
def patient_list():
    patients = Patient.query.all()
    # patients = Patient.query.with_entities(Patient.name, Patient.symptons.all()

    return render_template('patient_list.html', patients=patients)

if __name__ == '__main__':
    
    app.run(host='0.0.0.0', port=5000, debug=True)
