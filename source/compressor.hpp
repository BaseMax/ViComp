#ifndef COMPRESSOR_HPP
#define COMPRESSOR_HPP

#include <QCoreApplication>
#include <QtQml>
#include <QQmlContext>
#include <QObject>
#include <QProcess>

struct ActionType
{
    bool        run  {false};   //! Running main process.
    bool        busy {false};   //! Process is running (busy).
    QString     inputString{};  //! Process input string.
    QString     outputString{}; //! Process output string.
    QProcess *  process;        //! Process by QProcess.
};

/*!
 * \brief The Compressor class
 */
class Compressor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool         run         READ    run         WRITE   setRun          NOTIFY  runChanged)
    Q_PROPERTY(bool         busy        READ    busy        WRITE   setBusy         NOTIFY  busyChanged)
    Q_PROPERTY(QString      input       READ    input       WRITE   setInput        NOTIFY  inputChanged)
    Q_PROPERTY(QString      output      READ    output      WRITE   setOutput       NOTIFY  outputChanged)
public:
    explicit Compressor(QObject *parent = nullptr);
    ~Compressor();

    Q_INVOKABLE void compress(qint8 value);

    bool run() const;
    bool busy() const;
    QString input() const;
    QString output() const;

public slots:
    void setRun(bool run);
    void setBusy(bool busy);
    void setInput(QString input);
    void setOutput(QString output);

    //!Process
    void readyReadStandardOutput();
    void processStarted();
    void encodingFinished();

signals:
    void runChanged(bool run);
    void busyChanged(bool busy);
    void inputChanged(QString input);
    void outputChanged(QString output);

private:
    ActionType actionType{};
};

static void registerCompressorForQtQuick() {
    qmlRegisterType<Compressor>("Qt.Compressor", 1, 0, "Compressor");
}

Q_COREAPP_STARTUP_FUNCTION(registerCompressorForQtQuick)

#endif // COMPRESSOR_HPP
