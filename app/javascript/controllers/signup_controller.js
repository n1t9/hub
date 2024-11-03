import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "email",
    "emailError",
    "password",
    "passwordError",
    "submit",
  ];

  connect() {
    this.isEmailValid = false;
    this.isPasswordValid = false;
  }

  validateEmail() {
    const email = this.emailTarget.value;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (emailRegex.test(email)) {
      this.emailErrorTarget.classList.add("hidden");
      this.isEmailValid = true;
    } else {
      this.emailErrorTarget.classList.remove("hidden");
      this.isEmailValid = false;
    }
    this.toggleSubmitButton();
  }

  validatePassword() {
    const password = this.passwordTarget.value;

    // Minimum 8 characters, at least one letter, one number and one special character
    if (
      password.length >= 8 &&
      password.match(/[a-zA-Z]/) &&
      password.match(/[0-9\W]/)
    ) {
      this.passwordErrorTarget.classList.add("hidden");
      this.isPasswordValid = true;
    } else {
      this.passwordErrorTarget.classList.remove("hidden");
      this.isPasswordValid = false;
    }
    this.toggleSubmitButton();
  }

  toggleSubmitButton() {
    if (this.isEmailValid && this.isPasswordValid) {
      this.submitTarget.disabled = false;
      this.submitTarget.classList.remove("bg-gray-300");
      this.submitTarget.classList.add("bg-blue-600");
      this.submitTarget.classList.add("text-white");
      this.submitTarget.classList.add("cursor-pointer");
    } else {
      this.submitTarget.disabled = true;
      this.submitTarget.classList.remove("bg-blue-600");
      this.submitTarget.classList.add("bg-gray-300");
      this.submitTarget.classList.remove("text-white");
      this.submitTarget.classList.remove("cursor-pointer");
    }
  }
}
