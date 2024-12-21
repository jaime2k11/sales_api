class User < ApplicationRecord

	# Manejo de passwords mediante gema bcrypt
	has_secure_password

	# Valores permitidos para campo :role
	enum :role, { user: 0, seller: 1, admin: 2 }
	
	# Validaciones
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :role, presence: true, inclusion: { in: roles.keys }

	# Asociaciones	
	has_many :sales, dependent: :destroy

	before_save :set_default_role

	# Rol por defecto al crear el usuario	
	def set_default_role
		self.role ||= 0
	end

	# Metodo util para determinar si el usuario es trabajador del local (admin o seller)
	def staff?
		admin? || seller?
	end


end
