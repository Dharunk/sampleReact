// import React from 'react';

// function Welcome() {
//   return <h1>Welcome to the Dashboard!</h1>;
// }

// export default Welcome;
import React from 'react';
import { useNavigate } from 'react-router-dom'; 

function Welcome() {
  const navigate = useNavigate(); 

  const handleLogout = () => {
    // Clear the token from localStorage
    localStorage.removeItem('token');

    // Redirect to the login page
    navigate('/');
  };

  return (
    <div>
      <h1>Welcome to the Dashboard!</h1>
      <button onClick={handleLogout}>Logout</button>
    </div>
  );
}

export default Welcome;
