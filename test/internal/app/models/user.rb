class User < ActiveRecord::Base
  if respond_to?(:has_one_attached)
    has_one_attached :avatar
    attached_encrypted :avatar, key: Lockbox.generate_key

    has_many_attached :avatars
    attached_encrypted :avatars, key: Lockbox.generate_key

    has_one_attached :image
    has_many_attached :images
  end

  mount_uploader :document, DocumentUploader

  attr_encrypted :email, encryptor: Lockbox::Encryptor, key: Lockbox.generate_key, previous_versions: [{key: Lockbox.generate_key}]
  attr_accessor :encrypted_email_iv

  key_pair = Lockbox.generate_key_pair
  attr_encrypted :phone, encryptor: Lockbox::Encryptor, algorithm: "hybrid", encryption_key: key_pair[:encryption_key], decryption_key: key_pair[:decryption_key]
  attr_accessor :encrypted_phone_iv
end
