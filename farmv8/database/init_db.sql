-- AgriGrow PostgreSQL Database Schema
-- Created: 2026-08-20

-- Enable UUID extension if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. ADDRESSES TABLE
CREATE TABLE IF NOT EXISTS addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    country TEXT DEFAULT 'Philippines',
    region TEXT,
    region_code TEXT,
    province TEXT,
    province_code TEXT,
    municipality TEXT,
    municipality_code TEXT,
    barangay TEXT,
    barangay_code TEXT,
    street TEXT,
    house_number TEXT,
    postal_code TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. USERS TABLE (Shared Account Details)
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role TEXT NOT NULL CHECK (role IN ('farmer', 'logistics', 'bulk_buyer')),
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone_number TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. FARMERS TABLE
CREATE TABLE IF NOT EXISTS farmers (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    first_name TEXT NOT NULL,
    middle_name TEXT,
    last_name TEXT NOT NULL,
    personal_address_id UUID REFERENCES addresses(id),
    farm_address_id UUID REFERENCES addresses(id),
    farm_size DECIMAL(10, 2), -- in hectares
    utility_bill_path TEXT,
    valid_id_path TEXT,
    owners_address_doc_path TEXT,
    ownership_docs_path TEXT
);

-- 4. LOGISTICS TABLE
CREATE TABLE IF NOT EXISTS logistics (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    is_company BOOLEAN DEFAULT FALSE,
    -- Individual/Driver Details
    first_name TEXT,
    middle_name TEXT,
    last_name TEXT,
    dob DATE,
    gender TEXT,
    personal_address_id UUID REFERENCES addresses(id),
    -- Company Details
    company_name TEXT,
    business_reg_number TEXT,
    company_email TEXT,
    contact_number TEXT,
    company_address TEXT,
    -- Vehicle Details
    vehicle_type TEXT,
    vehicle_brand TEXT,
    vehicle_model TEXT,
    year_model TEXT,
    plate_number TEXT,
    vin TEXT,
    max_load_capacity TEXT,
    -- Document Paths
    driver_license_path TEXT,
    vehicle_or_path TEXT,
    vehicle_cr_path TEXT,
    vehicle_photo_path TEXT,
    government_id_path TEXT,
    nbi_clearance_path TEXT,
    driver_photo_path TEXT,
    driver_utility_bill_path TEXT,
    business_permit_path TEXT,
    bir_certificate_path TEXT,
    dti_sec_certificate_path TEXT,
    company_utility_bill_path TEXT
);

-- 5. BULK BUYERS TABLE
CREATE TABLE IF NOT EXISTS bulk_buyers (
    user_id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    business_name TEXT,
    business_address_id UUID REFERENCES addresses(id),
    bir_certificate_path TEXT,
    business_permit_path TEXT
);

-- SAMPLE DATA

-- Sample Addresses
INSERT INTO addresses (id, region, province, municipality, barangay, house_number, postal_code)
VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Region III', 'Pampanga', 'City of San Fernando', 'San Agustin', 'Unit 123', '2000'),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Region III', 'Pampanga', 'Mexico', 'Parian', 'Block 5 Lot 2', '2021');

-- Sample User (Farmer)
INSERT INTO users (id, role, username, email, phone_number, password_hash, is_verified)
VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'farmer', 'juan_farmer', 'juan@example.com', '09171234567', 'hashed_password_123', true);

INSERT INTO farmers (user_id, first_name, last_name, personal_address_id, farm_address_id, farm_size)
VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'Juan', 'Dela Cruz', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 2.5);

-- Sample User (Logistics)
INSERT INTO users (id, role, username, email, phone_number, password_hash, is_verified)
VALUES
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'logistics', 'fast_deliver', 'logistics@example.com', '09187654321', 'hashed_password_456', false);

INSERT INTO logistics (user_id, is_company, first_name, last_name, vehicle_type, plate_number)
VALUES
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', false, 'Maria', 'Santos', 'Pickup Truck', 'ABC 1234');

-- Sample User (Bulk Buyer)
INSERT INTO users (id, role, username, email, phone_number, password_hash, is_verified)
VALUES
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a55', 'bulk_buyer', 'supermarket_corp', 'buyer@example.com', '09199998888', 'hashed_password_789', true);

INSERT INTO bulk_buyers (user_id, first_name, last_name, business_name, business_address_id)
VALUES
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a55', 'Ricardo', 'Lim', 'Fresh Market Inc.', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
