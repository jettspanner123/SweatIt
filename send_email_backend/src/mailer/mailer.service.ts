import { Injectable } from '@nestjs/common';
import { MailerService as Mailer } from '@nestjs-modules/mailer';
import { FromEmailAddress } from '../constants/constants';

@Injectable()
export class MailerService {
  private mailerService: Mailer;

  async sendMainWithMessage(user: {
    email: string;
    fullName: string;
    message: string;
  }): Promise<boolean> {
    try {
      await this.mailerService.sendMail({
        from: FromEmailAddress,
        to: user.email,
        subject: ``,
        text: user.message,
      });
      return true;
    } catch {
      return false;
    }
  }
}
