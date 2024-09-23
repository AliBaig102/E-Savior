# E-Savior: Ambulance Management System

## Project Overview

E-Savior is a Flutter-based application designed to streamline the management of ambulance services within an organization. This app provides functionalities for administrators to efficiently manage ambulance and driver data, including adding, viewing, updating, and deleting ambulance profiles and driver information. With a user-friendly interface and robust backend integration, E-Savior enables seamless data handling and real-time updates.

## Features

- **User Authentication**: Secure login for different roles (admin and driver) to ensure data privacy.
- **Ambulance Management**: Administrators can add new ambulances, view existing ambulance details, update information, and delete ambulance profiles.
- **Driver Management**: Manage driver data with the ability to add, view, update, and delete driver profiles.
- **Input Validation**: Ensures that all user inputs are validated before submission to maintain data integrity.
- **Progress Indicators**: Visual feedback during data fetching and processing to enhance user experience.
- **Responsive Design**: Adapts well to various screen sizes, ensuring usability on both mobile and tablet devices.

## Functionalities

### User Roles

- **Admin**: 
  - Full access to all functionalities.
  - Can manage both ambulance and driver databases (add, update, delete).
  - Can view the list of all ambulances and drivers.

- **Driver**:
  - Can view personal information and contact details.
  - Limited access; cannot perform administrative functions.

### Authentication

- Users can log in using their credentials.
- Admins can access the admin panel to manage ambulance and driver data.
- User credentials:
  - **Admin**: 
    - Email: `admin@gmail.com`
    - Password: `admin123`
  - **Driver**:
    - Email: `khan@gmail.com`
    - Password: `khan123`
  - **User**:
    - Email: `ali@gmail.com`
    - Password: `admin123`

### Ambulance Management

- **Add Ambulance**: 
  - Admins can input new ambulance details, including type, registration number, and availability status.
  - Input fields include validation checks for proper formats and required fields.

- **View Ambulances**: 
  - Displays a list of all ambulances with their details, such as type, registration number, and current status.
  - Users can scroll through the list and view ambulance profiles at a glance.

- **Update Ambulance**: 
  - Admins can update existing ambulance information via a dedicated form.
  - Changes are saved and reflected in the ambulance list immediately.

- **Delete Ambulance**: 
  - Admins can delete an ambulance profile with a confirmation prompt to prevent accidental deletions.
  - The ambulance list updates in real-time after deletion.

### Driver Management

- **Add Driver**: 
  - Admins can input new driver details, including name, email, area, phone number, address, and assigned ambulance.
  
- **View Drivers**: 
  - Displays a list of all drivers with their details, including name, email, phone number, address, and assigned ambulance.

- **Update Driver**: 
  - Admins can update existing driver information via a dedicated form.

- **Delete Driver**: 
  - Admins can delete a driver profile with a confirmation prompt.

### User Interface

- The app features a clean and modern design with intuitive navigation.
- Utilizes Flutter's Material Design components for a consistent look and feel.
- Responsive layout that adjusts to different screen sizes for optimal usability.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE (e.g., Visual Studio Code, Android Studio)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/AliBaig102/E-Savior.git
   ```

2. Navigate to the project directory:
   ```bash
   cd E-Savior
   ```

3. Get the dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## Folder Structure

```
/lib
├── /core
│   └── my_colors.dart
├── /models
│   └── driver_model.dart
│   └── ambulance_model.dart
├── /services
│   └── driver_service.dart
│   └── ambulance_service.dart
├── /screens
│   └── driver_list_screen.dart
│   └── ambulance_list_screen.dart
├── /widgets
│   └── my_input.dart
└── main.dart

/assets
└── /images
    └── /avatars
```