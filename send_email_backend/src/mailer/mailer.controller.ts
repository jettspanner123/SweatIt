import { Body, Controller, Post } from '@nestjs/common';

@Controller('mailer')
export class MailerController {
  @Post('sendMail')
  setMain(@Body() user: { email: string; fullName: string }): boolean {
    return true;
  }
}
