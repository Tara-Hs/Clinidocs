#  dependences
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'bcrypt'

enable :sessions




def logged_in?()
  if session[:doctor_id]
    return true
  else
    return false
  end
end


def current_doctor
    db = PG.connect(dbname: 'clinidocs')
    sql = "SELECT * FROM doctors WHERE id = #{session[:doctor_id]};"
  
    results = db.exec(sql)
    return results[0]
end

def run_sql(sql, arr = [])
    db = PG.connect(dbname: 'clinidocs')
    results = db.exec_params(sql, arr)
    db.close
    return results
  
end



get '/' do
  redirect '/login' unless logged_in?

  patients = run_sql('SELECT * FROM patients;')
  erb :index, locals: {patients:patients}
end

get '/login' do
  erb :login
end


get '/patients/:id' do
 
  patient = run_sql("SELECT * FROM patients WHERE id = $1;", [params[:id]])[0]
  erb :patient_details, locals: { patient: patient }
end


post '/patients' do
  redirect '/login' unless logged_in?

  sql = "insert into patients (name, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) values ($1, $2, $3, $4, $5, $6, $7, $8)"
  run_sql(sql, [
    params[:name], 
    params[:contact_details], 
    params[:address],
    params[:medicare_number],
    params[:date_of_birth],
    params[:height],
    params[:weight],
    params[:blood_type],
    current_doctor()['id']
  ])

  redirect '/'
end



post '/sessions' do

    db = PG.connect(dbname: 'clinidocs')
    sql = "SELECT * FROM doctors WHERE email = '#{params[:email]}';"
    results = db.exec(sql) 

    if results.count == 1 && BCrypt::Password.new(results[0]['password_digest']).==(params[:password])
      
      session[:doctor_id] = results[0]['id']
      redirect('/')
    else  
      erb :login
    end
  
end




delete '/sessions' do
  session[:doctor_id] = nil
  redirect '/login'
end



get '/treatment_notes/:id' do
 
  treatment_note = run_sql("SELECT * FROM treatment_notes WHERE id = $1;", [params[:id]])[0]
  erb :treatment_notes, locals: { treatment_note: treatment_note }
end


get '/treatment_notes' do
  erb :treatment_notes
end

get '/update' do
  "Hello World"
end

get '/new_pt' do
  erb :new_pt
end

post '/patient_details' do

  sql = "insert into patients (name, surname, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) values ($1, $2, $3, $4, $5, $6, $7, $8, $9)"
  run_sql(sql, [
    params[:name], 
    params[:surname],
    params[:contact_details], 
    params[:address],
    params[:medicare_number],
    params[:date_of_birth],
    params[:height],
    params[:weight],
    params[:blood_type],
  ])

  redirect '/'
end


delete '/patients/:id' do
  
  
  patient = run_sql("DELETE FROM patients WHERE id = $1;", [params[:id]])

  
  redirect('/')
end

